Class cysnet.clinicaDental.agenda.msg.AltaCitaRequest Extends Ens.Request
{

// Identificador del paciente

Property idPaciente As %Integer;

// Descripción de la cita (por ejemplo: Nueva consulta odontología)

Property descCita As %String;

// Fecha/hora de la cita

Property fechaCita As %TimeStamp;

// Estado de la cita

Property codEstado As %Integer;

Storage Default
{
<Data name="AltaCitaRequestDefaultData">
<Subscript>"AltaCitaRequest"</Subscript>
<Value name="1">
<Value>idPaciente</Value>
</Value>
<Value name="2">
<Value>descCita</Value>
</Value>
<Value name="3">
<Value>fechaCita</Value>
</Value>
<Value name="4">
<Value>codEstado</Value>
</Value>
</Data>
<DefaultData>AltaCitaRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
