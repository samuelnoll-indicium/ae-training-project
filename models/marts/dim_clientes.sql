with 
    stg_customer as (
        select * from {{ ref('stg_adventure_works__sales_customer') }}
    ),

    stg_person as (
        select * from {{ ref('stg_adventure_works__person_person') }}
    ),

    joined as (
        select
            c.id_cliente,
            c.id_pessoa,
            c.id_loja,
            -- Se for um cliente que é pessoa física, traz o nome, senão coloca que é Loja/Empresa
            coalesce(p.nome_completo, 'Loja/Corporativo') as nome_cliente
        from stg_customer c
        left join stg_person p on c.id_pessoa = p.id_pessoa
    ),

    transformed as (
        select
            -- Gerando a SK do cliente
            md5(cast(id_cliente as string)) as sk_cliente,
            id_cliente,
            id_pessoa,
            id_loja,
            nome_cliente
        from joined
    )

select *
from transformed