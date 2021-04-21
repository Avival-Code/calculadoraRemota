$:.push('gen-rb')

require 'thrift'
require 'calculadora_remota'

puerto = 8080

transporte = Thrift::Socket.new( '192.168.1.164', puerto )
transporte = Thrift::BufferedTransport.new( transporte )
protocolo = Thrift::BinaryProtocol.new( transporte )

cliente = CalculadoraRemota::Client.new( protocolo )

transporte.open()

activo = true
while activo == true
	puts "1 - Suma, 2 - Resta, 3 - Multiplicación, 4 - División, 5 - Salir"
	puts "Introduce la opción de la operación que desea realizar:"
	userInput = gets

	if userInput.to_i == 1
		puts "Introduce el primer numero de la suma: "
		numero1 = gets
		puts "Introduce el segundo numero de la suma: "
		numero2 = gets
		resultado = cliente.add( numero1.to_i, numero2.to_i )
		puts "El resultado de tu suma es: " + resultado.to_s

	elsif userInput.to_i == 2
		puts "Introduce el primer numero de la resta: "
		numero1 = gets
		puts "Introduce el segundo numero de la resta: "
		numero2 = gets
		resultado = cliente.substract( numero1.to_i, numero2.to_i )
		puts "El resultado de tu resta es: " + resultado.to_s

	elsif userInput.to_i == 3
		puts "Introduce el primer numero de la multiplicación: "
		numero1 = gets
		puts "Introduce el segundo numero de la multiplicación: "
		numero2 = gets
		resultado = cliente.multiply( numero1.to_i, numero2.to_i )
		puts "El resultado de tu multiplicación es: " + resultado.to_s

	elsif userInput.to_i == 4
		puts "Introduce el primer numero de la división: "
		numero1 = gets
		puts "Introduce el segundo numero de la división: "
		numero2 = gets
		resultado = cliente.divide( numero1.to_i, numero2.to_i )
		puts "El resultado de tu división es: " + resultado.to_s

	else userInput.to_i == 5
		puts "Cerrando calculadora. Hasta luego..."
		activo = false
	end

end

puts "Closing client..."
transporte.close()