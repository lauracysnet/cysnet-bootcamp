Class cysnet.clinicaDental.agenda.msg.ListarCitasRequest Extends Ens.Request
{

// Indica si muestra las citas canceladas también

Property mostrarCanceladas As %Boolean;

Storage Default
{
<Data name="ListarCitasRequestDefaultData">
<Subscript>"ListarCitasRequest"</Subscript>
<Value name="1">
<Value>mostrarCanceladas</Value>
</Value>
</Data>
<DefaultData>ListarCitasRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
