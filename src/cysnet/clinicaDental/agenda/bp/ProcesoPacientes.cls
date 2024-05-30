/// 
Class cysnet.clinicaDental.agenda.bp.ProcesoPacientes Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='nombre' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='apellidos' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='email' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='exito' type='%Boolean' instantiate='0' />
<property name='idPaciente' type='%Integer' instantiate='0' />
<property name='asunto' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='mensaje' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
</context>
<sequence xend='200' yend='700' >
<call name='Nuevo Paciente' target='PacientesSQL' async='1' xpos='200' ypos='250' >
<request type='cysnet.clinicaDental.agenda.msg.CrearPacienteRequest' >
<assign property="callrequest.nombre" value="context.nombre" action="set" />
<assign property="callrequest.apellidos" value="context.apellidos" action="set" />
<assign property="callrequest.email" value="context.email" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.CrearPacienteResponse' >
<assign property="context.exito" value="callresponse.exito" action="set" />
</response>
</call>
<if name='¿Registro OK?' condition='context.exito = 1' xpos='200' ypos='350' xend='200' yend='600' >
<true>
<call name='Notificacion' target='NotificacionesSQL' async='1' xpos='335' ypos='500' >
<request type='cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionesRequest' >
<assign property="callrequest.idPaciente" value="context.idPaciente" action="set" />
<assign property="callrequest.asunto" value="context.asunto" action="set" />
<assign property="callrequest.mensaje" value="context.mensaje" action="set" />
</request>
<response type='cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionesResponse' />
</call>
</true>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
