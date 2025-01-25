extends Area2D

func _ready():
	print("Item inicializado")
	body_entered.connect(_on_body_entered)
	print("Sinal conectado")

func _on_body_entered(body):
	print("Colisão detectada com: ", body.name)
	if body is Player:
		print("Colisão confirmada com player!")
		body.itensColetados += 1
		#print("Contador de itens: ", body.itensColetados)
		queue_free()
