package main

import (
	"fmt"
	"os"

	"golang.org/x/term"
)

func main() {
	w, h, err := term.GetSize(0)
	if err != nil {
		fmt.Println("failed to get terminal size")
		os.Exit(1)
	}

	fmt.Println(w, "x", h)
}
