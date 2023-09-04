package main

import (
	"fmt"
	"syscall/js"
)

// Exportando a função para o JavaScript como imprimirMensagem
func imprimirMensagem(mensagem string) {
	fmt.Println(mensagem)
}

// Função de registro.
func registrar() {
	js.Global().Set("imprimirMensagem", js.FuncOf(func(this js.Value, args []js.Value) interface{} {
		imprimirMensagem(args[0].String())
		return nil
	}))
}

// Executa o registro quando a WASM é carregada
func main() {
	registrar()
}
