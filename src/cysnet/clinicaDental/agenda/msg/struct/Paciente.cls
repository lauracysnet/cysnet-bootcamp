Class cysnet.clinicaDental.agenda.msg.struct.Paciente Extends (%SerialObject, %XML.Adaptor)
{

Property id As %Integer;

Property nombre As %String;

Property apellidos As %String;

Property email As %String;

Property permiteNotificaciones As %Boolean;

Property baja As %Boolean;

Storage Default
{
<Data name="PacienteState">
<Value name="1">
<Value>nombre</Value>
</Value>
<Value name="2">
<Value>apellidos</Value>
</Value>
<Value name="3">
<Value>email</Value>
</Value>
<Value name="4">
<Value>permiteNotificaciones</Value>
</Value>
<Value name="5">
<Value>baja</Value>
</Value>
<Value name="6">
<Value>id</Value>
</Value>
</Data>
<State>PacienteState</State>
<StreamLocation>^cysnet.clinicaDent8AF.PacienteS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
