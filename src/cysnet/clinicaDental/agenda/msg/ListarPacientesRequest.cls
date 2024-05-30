Class cysnet.clinicaDental.agenda.msg.ListarPacientesRequest Extends Ens.Request
{

// Por defecto, 0 (false)

// Si se pasa este parámetro a 1 (true), devolverá la lista de pacientes completa, incluidos los que están de baja

Property mostrarBajas As %Boolean;

Storage Default
{
<Data name="ListarPacientesRequestDefaultData">
<Subscript>"ListarPacientesRequest"</Subscript>
<Value name="1">
<Value>mostrarBajas</Value>
</Value>
</Data>
<DefaultData>ListarPacientesRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
