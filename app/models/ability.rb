# encoding: UTF-8

class Ability < Sivel2Sjr::Ability

    ROLADMIN  = 1
    ROLINV    = 2
    ROLDIR    = 3
    ROLCOOR   = 4
    ROLANALI  = 5
    ROLSIST   = 6
    ROLANALIPRENSA  = 7

    ROLES = [
      ["Administrador", ROLADMIN], 
      ["Invitado Nacional", ROLINV], 
      ["Director Nacional", ROLDIR], 
      ["Coordinador oficina", ROLCOOR], 
      ["Analista", ROLANALI], 
      ["Sistematizador", ROLSIST],
      ["Analista de Prensa", ROLANALIPRENSA]
    ]

  BASICAS_PROPIAS =  [
    ['Sivel2Sjr', 'acreditacion'], 
    ['Sivel2Sjr', 'ayudaestado'], 
    ['Sivel2Sjr', 'clasifdesp'], 
    ['Sivel2Sjr', 'declaroante'], 
    ['Sivel2Sjr', 'derecho'], 
    ['Sivel2Sjr', 'inclusion'], 
    ['Sivel2Sjr', 'modalidadtierra'], 
    ['Sivel2Sjr', 'motivosjr'], 
    ['Sivel2Sjr', 'personadesea'], 
    ['Sivel2Sjr', 'progestado'], 
    ['Sivel2Sjr', 'regimensalud'],
    ['Sivel2Sjr', 'tipodesp']
  ]
  
  @@tablasbasicas = Sip::Ability::BASICAS_PROPIAS + 
    Cor1440Gen::Ability::BASICAS_PROPIAS +
    Sal7711Gen::Ability::BASICAS_PROPIAS + 
    Sivel2Gen::Ability::BASICAS_PROPIAS + 
    Sivel2Sjr::Ability::BASICAS_PROPIAS + 
    BASICAS_PROPIAS - [
      ['Sivel2Gen', 'filiacion'],
      ['Sivel2Gen', 'frontera'],
      ['Sivel2Gen', 'iglesia'],
      ['Sivel2Gen', 'intervalo'],
      ['Sivel2Gen', 'organizacion'],
      ['Sivel2Gen', 'pconsolidado'],
      ['Sivel2Gen', 'region'],
      ['Sivel2Gen', 'sectorsocial'],
      ['Sivel2Gen', 'vinculoestado'],
      ['Sivel2Sjr', 'idioma']
  ]

  @@basicas_id_noauto = Sip::Ability::BASICAS_ID_NOAUTO +
    Sivel2Gen::Ability::BASICAS_ID_NOAUTO 

  @@nobasicas_indice_seq_con_id = Sip::Ability::NOBASICAS_INDSEQID +
    Sivel2Gen::Ability::NOBASICAS_INDSEQID 

  @@tablasbasicas_prio = Sip::Ability::BASICAS_PRIO +
    Sivel2Gen::Ability::BASICAS_PRIO +
    Sivel2Sjr::Ability::BASICAS_PRIO

  def initialize(usuario)
    super(usuario)
    can :read, Sal7711Gen::Categoriaprensa      
    if usuario && usuario.rol then
        can :read, Sal7711Gen::Articulo
        case usuario.rol
        when Ability::ROLADMIN, Ability::ROLDIR, Ability::ROLANALI
          can :manage, Sal7711Gen::Articulo
        when Ability::ROLANALIPRENSA, Ability::ROLADMIN, Ability::ROLDIR, Ability::ROLANALI
          can :manage, Sal7711Gen::Articulo
          can :read, Cor1440Gen::Informe
          can :read, Cor1440Gen::Actividad
          can :new, Cor1440Gen::Actividad
          can [:update, :create, :destroy], Cor1440Gen::Actividad, 
            oficina: { id: usuario.oficina_id}
        end
    end
  end

end
