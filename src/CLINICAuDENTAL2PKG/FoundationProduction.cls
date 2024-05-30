Class CLINICAuDENTAL2PKG.FoundationProduction Extends Ens.Production [ Not ProcedureBlock ]
{

XData ProductionDefinition
{
<Production Name="CLINICAuDENTAL2PKG.FoundationProduction" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>1</ActorPoolSize>
  <Item Name="GestionPacientes" Category="" ClassName="cysnet.clinicaDental.agenda.ws.GestionPacientes" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Port">1981</Setting>
  </Item>
  <Item Name="GestionCitas" Category="" ClassName="cysnet.clinicaDental.agenda.ws.GestionCitas" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Port">1982</Setting>
  </Item>
  <Item Name="PacientesSQL" Category="" ClassName="cysnet.clinicaDental.agenda.bo.PacientesSQL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="CitasSQL" Category="" ClassName="cysnet.clinicaDental.agenda.bo.CitasSQL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="AdmisionesSQL" Category="" ClassName="cysnet.clinicaDental.agenda.bo.AdmisionesSQL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="AltasSQL" Category="" ClassName="cysnet.clinicaDental.agenda.bo.AltasSQL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="NotificacionesSQL" Category="" ClassName="cysnet.clinicaDental.notificaciones.bo.NotificacionesSQL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ProcesoPacientes" Category="" ClassName="cysnet.clinicaDental.agenda.bp.ProcesoPacientes" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
