Class cysnet.clinicaDental.agenda.msg.ListarCitasResponse Extends Ens.Response
{

Property citas As list Of cysnet.clinicaDental.agenda.msg.struct.Cita;

Storage Default
{
<Data name="ListarCitasResponseDefaultData">
<Subscript>"ListarCitasResponse"</Subscript>
<Value name="1">
<Value>citas</Value>
</Value>
</Data>
<DefaultData>ListarCitasResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
