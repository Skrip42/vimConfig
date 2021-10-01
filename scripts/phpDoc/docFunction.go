package main

import (
	"errors"
	"fmt"
	"io/ioutil"
	"os"
	"regexp"
)

type PhpFuncData struct {
	Offset string
	Name   string
	Params []PhpFuncArgData
	Throws []PhpFuncThrowData
	Return string
}

type PhpFuncArgData struct {
	Type    string
	Name    string
	Default string
}

type PhpFuncThrowData struct {
	Name string
}

func main() {
	f, err := ioutil.ReadAll(os.Stdin)
	if err != nil {
		panic(err)
	}
	reg, err := regexp.Compile("(\\s*)(?:public|private|protected)?\\s*function\\s+([\\w\\d]+)\\(([\\w\\s$\\,=\\[\\]\\\\\\.\\\"\\']*)\\)\\s*\\:?\\s?([\\w\\d]+)?")
	if err != nil {
		panic(err)
	}
	matches := reg.FindAllStringSubmatch(string(f), 1)
	if len(matches) < 1 {
		panic(errors.New("function not found"))
	}
	match := matches[0]

	phpfunc := PhpFuncData{"", "", []PhpFuncArgData{}, []PhpFuncThrowData{}, ""}
	phpfunc.Offset = match[1]
	phpfunc.Name = match[2]
	phpfunc.Return = match[4]

	params := match[3]

	reg, err = regexp.Compile("(?:([\\w\\d\\\\]+)\\s)?((?:\\.{3})?\\$[\\w\\d]+)\\s?=?\\s?([^,\\n]+)?")
	if err != nil {
		panic(err)
	}
	matches = reg.FindAllStringSubmatch(params, 20)
	for _, match := range matches {
		arg := PhpFuncArgData{"", "", ""}
		arg.Type = match[1]
		arg.Name = match[2]
		arg.Default = match[3]
		phpfunc.Params = append(phpfunc.Params, arg)
	}
	reg, err = regexp.Compile("\\s*throw\\s+new\\s+([\\w\\d\\\\]+)")
	if err != nil {
		panic(err)
	}
	matches = reg.FindAllStringSubmatch(string(f), 20)

	for _, match := range matches {
		throw := PhpFuncThrowData{""}
		throw.Name = match[1]
		phpfunc.Throws = append(phpfunc.Throws, throw)
	}

	maxArgTypeSize := 0
	maxArgNameSize := 0
	for _, param := range phpfunc.Params {
		if len(param.Type) > maxArgTypeSize {
			maxArgTypeSize = len(param.Type)
		}
		if len(param.Name) > maxArgNameSize {
			maxArgNameSize = len(param.Name)
		}
	}

	fmt.Println(phpfunc.Offset + "/**")
	for _, param := range phpfunc.Params {
		fmt.Print(phpfunc.Offset + " * @param ")
		if param.Type == "" {
			param.Type = "mixed"
		}
		fmt.Print(PadRight(param.Type, " ", maxArgTypeSize))
		fmt.Print(" " + PadRight(param.Name, " ", maxArgNameSize))
		if param.Default != "" {
			fmt.Print(" by default " + param.Default)
		}
		fmt.Print("\n")
	}
	if phpfunc.Return != "" {
		fmt.Println(phpfunc.Offset + " * ")
		fmt.Println(phpfunc.Offset + " * @return " + phpfunc.Return)
	}
	if len(phpfunc.Throws) > 0 {
		fmt.Println(phpfunc.Offset + " * ")
		for _, throw := range phpfunc.Throws {
			fmt.Println(phpfunc.Offset + " * @throw " + throw.Name)
		}
	}
	fmt.Println(phpfunc.Offset + " */")

	fmt.Println(string(f))
}

func PadRight(str, pad string, lenght int) string {
	for {
		str += pad
		if len(str) > lenght {
			return str[0:lenght]
		}
	}
}
