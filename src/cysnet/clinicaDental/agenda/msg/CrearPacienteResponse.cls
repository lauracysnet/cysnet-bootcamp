Class cysnet.clinicaDental.agenda.msg.CrearPacienteResponse Extends Ens.Response
{

// Informa si la petición se realizó o no

Property exito As %Boolean;

// Contiene el mensaje de error en caso de que se genere alguno

Property mensaje As %String;

// Ultimo ID agregado en la db

Property lastID As %BigInt;

Storage Default
{
<Data name="CrearPacienteResponseDefaultData">
<Subscript>"CrearPacienteResponse"</Subscript>
<Value name="1">
<Value>exito</Value>
</Value>
<Value name="2">
<Value>mensaje</Value>
</Value>
<Value name="3">
<Value>id</Value>
</Value>
<Value name="4">
<Value>lastID</Value>
</Value>
</Data>
<DefaultData>CrearPacienteResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
