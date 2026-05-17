with 
    stg_address as (
        select * from {{ ref('stg_adventure_works__person_address') }}
    ),

    stg_state as (
        select * from {{ ref('stg_adventure_works__person_stateprovince') }}
    ),

    stg_country as (
        select * from {{ ref('stg_adventure_works__person_countryregion') }}
    ),

    joined as (
        select
            a.id_endereco,
            a.cidade,
            s.nome_estado,
            c.nome_pais
        from stg_address a
        left join stg_state s on a.id_estado = s.id_estado
        left join stg_country c on s.codigo_pais = c.codigo_pais
    ),

    transformed as (
        select
            md5(cast(id_endereco as string)) as sk_localidade,
            id_endereco,
            cidade,
            nome_estado as estado,
            nome_pais as pais
        from joined
    )

select *
from transformed