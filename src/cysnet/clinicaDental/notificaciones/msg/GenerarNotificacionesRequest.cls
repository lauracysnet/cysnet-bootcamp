Class cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionesRequest Extends Ens.Request
{

//  Identificador del paciente

Property idPaciente As %Integer;

// Asunto del email a enviar

Property asunto As %String;

// Mensaje a enviar por email

Property mensaje As %String;

Storage Default
{
<Data name="GenerarNotificacionesRequestDefaultData">
<Subscript>"GenerarNotificacionesRequest"</Subscript>
<Value name="1">
<Value>idPaciente</Value>
</Value>
<Value name="2">
<Value>asunto</Value>
</Value>
<Value name="3">
<Value>mensaje</Value>
</Value>
</Data>
<DefaultData>GenerarNotificacionesRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
