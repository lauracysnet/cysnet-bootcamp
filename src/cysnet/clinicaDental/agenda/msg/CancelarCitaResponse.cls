Class cysnet.clinicaDental.agenda.msg.CancelarCitaResponse Extends Ens.Response
{

// Informa si la petición se realizó o no

Property exito As %Boolean;

// Contiene el mensaje de error en caso de que se genere alguno

Property mensaje As %String;

Storage Default
{
<Data name="CancelarCitaResponseDefaultData">
<Subscript>"CancelarCitaResponse"</Subscript>
<Value name="1">
<Value>exito</Value>
</Value>
<Value name="2">
<Value>mensaje</Value>
</Value>
</Data>
<DefaultData>CancelarCitaResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
