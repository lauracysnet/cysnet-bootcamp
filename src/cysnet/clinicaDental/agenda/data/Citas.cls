Class cysnet.clinicaDental.agenda.data.Citas Extends %Persistent
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
<Data name="CitasDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>idPaciente</Value>
</Value>
<Value name="3">
<Value>descCita</Value>
</Value>
<Value name="4">
<Value>fechaCita</Value>
</Value>
<Value name="5">
<Value>codEstado</Value>
</Value>
</Data>
<DataLocation>^cysnet.clinicaDental505B.CitasD</DataLocation>
<DefaultData>CitasDefaultData</DefaultData>
<IdLocation>^cysnet.clinicaDental505B.CitasD</IdLocation>
<IndexLocation>^cysnet.clinicaDental505B.CitasI</IndexLocation>
<StreamLocation>^cysnet.clinicaDental505B.CitasS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
