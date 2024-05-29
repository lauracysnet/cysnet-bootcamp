Class cysnet.clinicaDental.agenda.data.Altas Extends %Persistent
{

// Identificador de la cita

Property idCita As %Integer;

// Fecha/hora en la que el paciente se va de la Clínica (cuando ha terminado su cita)

Property fechaAlta As %TimeStamp;

// Indicador de si los datos del alta se han enviado

Property indEnviada As %Boolean;

Storage Default
{
<Data name="AltasDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>idCita</Value>
</Value>
<Value name="3">
<Value>fechaAlta</Value>
</Value>
<Value name="4">
<Value>indEnviada</Value>
</Value>
</Data>
<DataLocation>^cysnet.clinicaDental505B.AltasD</DataLocation>
<DefaultData>AltasDefaultData</DefaultData>
<IdLocation>^cysnet.clinicaDental505B.AltasD</IdLocation>
<IndexLocation>^cysnet.clinicaDental505B.AltasI</IndexLocation>
<StreamLocation>^cysnet.clinicaDental505B.AltasS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
