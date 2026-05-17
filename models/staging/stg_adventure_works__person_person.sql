with 
    source as (
        select * from {{ source('adventure_works', 'person_person') }}
    ),

    renamed as (
        select
            businessentityid as id_pessoa,
            firstname || ' ' || coalesce(middlename || ' ', '') || lastname as nome_completo,
            persontype as tipo_pessoa
        from source
    )

select *
from renamed