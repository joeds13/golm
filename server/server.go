package main

import (
	"encoding/json"
	"fmt"
	"html/template"
	"log"
	"net/http"
	"path/filepath"
)

func main() {
	http.HandleFunc("/", serveTemplate)
	http.HandleFunc("/api/v1/", serveAPI)
	http.HandleFunc("/js/", serveStatic)

	log.Println("Listening on :1337")
	http.ListenAndServe(":1337", nil)
}

func serveAPI(w http.ResponseWriter, r *http.Request) {
	world := map[string]string{"hello": "world"}
	hello, _ := json.Marshal(world)
	fmt.Fprintln(w, string(hello))
}

func serveStatic(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, filepath.Join(".", r.URL.Path))
}

func serveTemplate(w http.ResponseWriter, r *http.Request) {
	index := filepath.Join("templates", "index.html")

	template, _ := template.ParseFiles(index)
	err := template.ExecuteTemplate(w, "index", index)
	if err != nil {
		log.Println(err.Error())
		http.Error(w, err.Error(), 500)
		return
	}
}
