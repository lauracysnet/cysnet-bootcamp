Class cysnet.clinicaDental.agenda.msg.ModificarCitaRequest Extends Ens.Request
{

Property idCita As %Integer;

Property fechaCitaNueva As %TimeStamp;

Storage Default
{
<Data name="ModificarCitaRequestDefaultData">
<Subscript>"ModificarCitaRequest"</Subscript>
<Value name="1">
<Value>idCita</Value>
</Value>
<Value name="2">
<Value>fechaCitaNueva</Value>
</Value>
</Data>
<DefaultData>ModificarCitaRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
