with 
    source as (
        select * from {{ source('adventure_works', 'person_countryregion') }}
    ),

    renamed as (
        select
            countryregioncode as codigo_pais,
            name as nome_pais
        from source
    )

select *
from renamed