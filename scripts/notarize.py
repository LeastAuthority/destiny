#!/usr/bin/env python3

# Copied with minor modifications from:
# https://raw.githubusercontent.com/gridsync/gridsync/45041a22200fd524bc8ad7fe629c3880266df2fe/scripts/notarize.py

import hashlib
import os
import sys
from configparser import RawConfigParser
from pathlib import Path
from subprocess import run, CalledProcessError, SubprocessError
from time import sleep
from typing import Optional

altool = "/Applications/Xcode.app/Contents/Developer/usr/bin/altool"
stapler = "/Applications/Xcode.app/Contents/Developer/usr/bin/stapler"

# https://developer.apple.com/documentation/xcode/notarizing_macos_software_before_distribution/customizing_the_notarization_workflow
# https://stackoverflow.com/questions/56890749/macos-notarize-in-script/56890758#56890758
# https://github.com/metabrainz/picard/blob/master/scripts/package/macos-notarize-app.sh

# security unlock-keychain login.keychain
# altool --store-password-in-keychain-item gridsync-notarization -u $APPLE_ID -p $APP_SPECIFIC_PASSWORD


def sha256sum(filepath):
    hasher = hashlib.sha256()
    with open(filepath, "rb") as f:
        for block in iter(lambda: f.read(4096), b""):
            hasher.update(block)
    return hasher.hexdigest()


def make_zipfile(src_path: str, dst_path: str) -> None:
    run(["ditto", "-c", "-k", "--keepParent", src_path, dst_path])


def notarize_app(
    path: str, bundle_id: str, username: str, password: str
) -> str:
    completed_process = run(
        [
            altool,
            "--notarize-app",
            f"--file={path}",
            f"--primary-bundle-id={bundle_id}",
            f"--username={username}",
            f"--password={password}",
        ],
        capture_output=True,
        text=True,
    )
    stdout = completed_process.stdout.strip()
    stderr = completed_process.stderr.strip()
    if completed_process.returncode or stderr:
        s = "The software asset has already been uploaded. The upload ID is "
        if s in stderr:
            print(f"{path} has already been uploaded")
            start = stderr.index(s) + len(s)
            uuid = stderr[start : start + 36]
            return uuid
        raise SubprocessError(stderr)
    if stdout.startswith("No errors uploading"):
        uuid = stdout.split()[-1]
        return uuid


def notarization_info(uuid: str, username: str, password: str) -> dict:
    completed_process = run(
        [
            altool,
            "--notarization-info",
            uuid,
            f"--username={username}",
            f"--password={password}",
        ],
        capture_output=True,
        text=True,
    )
    stdout = completed_process.stdout.strip()
    stderr = completed_process.stderr.strip()
    if completed_process.returncode or stderr:
        raise SubprocessError(stderr)
    results = {}
    for line in stdout.split("\n"):
        if line:
            split = line.split(":")
            key = split[0].strip()
            value = ":".join(split[1:]).strip()
            if key and value:
                results[key] = value
    return results


def staple(path: str) -> None:
    p = run([stapler, "staple", path])
    if p.returncode:
        raise SubprocessError(f"Error stapling {path}")


def notarize(
    path: str,
    bundle_id: str,
    username: str,
    password: str,
    sha256_hash: Optional[str] = None,
) -> str:
    if sha256_hash:
        print(f"Uploading {path} ({sha256_hash}) for notarization...")
    else:
        print(f"Uploading {path} for notarization...")
    uuid = notarize_app(path, bundle_id, username, password)
    print(f"UUID is {uuid}")
    hash_verified = False
    notarized = False
    print("Awaiting response...")
    while not notarized:
        results = notarization_info(uuid, username, password)
        print(results)
        status = results["Status"]
        if sha256_hash and not hash_verified:
            remote_hash = results.get("Hash")
            if remote_hash:
                if remote_hash == sha256_hash:
                    hash_verified = True
                    print("Hashes match.")
                else:
                    raise Exception(
                        f"Hash mismatch! The local SHA256 hash ({sha256_hash})"
                        f" does not match the remote file ({remote_hash})"
                    )
        if status == "success":
            notarized = True
        elif status == "invalid":
            sys.exit(results["Status Message"])
        else:
            sleep(20)


if __name__ == "__main__":
    config = RawConfigParser(allow_no_value=True)
    config.read(Path("scripts/notarization_config.txt"))
    settings = {}
    for section in config.sections():
        if section not in settings:
            settings[section] = {}
        for option, value in config.items(section):
            settings[section][option] = value
    application_name = settings["application"]["name"]
    bundle_id = settings["build"]["mac_bundle_identifier"]

    username = os.environ.get("NOTARIZATION_USERNAME")  # Apple ID
    password = os.environ.get(
        "NOTARIZATION_PASSWORD", "@keychain:login"
    )

    dist_path = "build/macos/Build/Products/Release"

    option = sys.argv[1]
    if option == "app":
        notarize_path = f"{dist_path}/{application_name}.zip"
        staple_path = f"{dist_path}/{application_name}.app"
        print("Creating ZIP archive...")
        make_zipfile(staple_path, notarize_path)
    elif option == "dmg":
        notarize_path = f"{dist_path}/{application_name}.dmg"
        staple_path = f"{dist_path}/{application_name}.dmg"

    sha256_hash = sha256sum(notarize_path)
    try:
        notarize(notarize_path, bundle_id, username, password, sha256_hash)
    except SubprocessError as err:
        sys.exit(str(err))
    try:
        staple(staple_path)
    except SubprocessError as err:
        sys.exit(str(err))
    print("Success!")
    if option == "dmg":
        sha256_hash = sha256sum(staple_path)
        print(f"{sha256_hash}  {staple_path}")
