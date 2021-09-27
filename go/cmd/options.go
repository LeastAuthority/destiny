package main

import (
	"github.com/go-flutter-desktop/go-flutter"
      file_picker "github.com/miguelpruivo/flutter_file_picker/go"
)

var options = []flutter.Option{
	flutter.AddPlugin(&file_picker.FilePickerPlugin{}),
	flutter.WindowInitialDimensions(360,640),
}