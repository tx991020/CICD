package main

import (
	"gitlab.yc345.tv/backend/onion_util/logs"
	"github.com/gin-gonic/gin"
	"net/http"
)

//import (
//	"fmt"
//	"log"
//	"net/http"
//)
//
//func handler(w http.ResponseWriter, r *http.Request) {
//	fmt.Fprintf(w, "leeroooooy app!!\n")
//}
//
//func main() {
//	log.Print("leeroy app server ready222")
//	http.HandleFunc("/", handler)
//	http.ListenAndServe(":50051", nil)
//
//}
//

func main() {
	r := gin.Default()
	
	
	r.GET("/hello", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"ok": "hello"})
	})
	logs.Info("haha")
	r.Run(":5001")
}
