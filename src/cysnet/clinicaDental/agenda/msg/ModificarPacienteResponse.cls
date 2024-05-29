Class cysnet.clinicaDental.agenda.msg.ModificarPacienteResponse Extends Ens.Response
{

// Informa si la petición se realizó o no

Property exito As %Boolean;

// Contiene el mensaje de error en caso de que se genere alguno

Property mensaje As %String;

Storage Default
{
<Data name="ModificarPacienteResponseDefaultData">
<Subscript>"ModificarPacienteResponse"</Subscript>
<Value name="1">
<Value>exito</Value>
</Value>
<Value name="2">
<Value>mensaje</Value>
</Value>
</Data>
<DefaultData>ModificarPacienteResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
