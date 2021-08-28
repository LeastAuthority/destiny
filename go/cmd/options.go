package main

import (
      file_picker "github.com/miguelpruivo/flutter_file_picker/go"
)

var options = []flutter.Option{
	flutter.AddPlugin(&file_picker.FilePickerPlugin{}),
}