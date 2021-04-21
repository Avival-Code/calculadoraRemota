import sys
sys.path.append('gen-py')

from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol
from thrift.server import TServer

from calculadoraService import CalculadoraRemota

class CalculadoraRemotaHandler( CalculadoraRemota.Iface ):
	def add( self, number1, number2 ):
		print( "Calculando suma..." )
		return number1 + number2

	def subtract( self, number1, number2 ):
		print( "Calculando resta..." )
		return number1 - number2

	def multiply( self, number1, number2 ):
		print( "Calculando multiplicación..." )
		return number1 * number2

	def divide( self, number1, number2 ):
		if number2 == 0:
			print( "No puedes dividir por 0!" )
			return 0.0
		else:
			print( "Calculando división..." )
			return double( number1 / number2 )

manejador = CalculadoraRemotaHandler()
procesador = CalculadoraRemota.Processor( manejador )
transporte_servidor = TSocket.TServerSocket( port=8080 )
transporte_fact = TTransport.TBufferedTransportFactory()
protocol_fact = TBinaryProtocol.TBinaryProtocolFactory()
servidor = TServer.TSimpleServer( procesador, transporte_servidor, transporte_fact, protocol_fact )

print( "Server started..." )
servidor.serve()
print( "Server shut down..." )