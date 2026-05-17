with 
    source as (
        select * from {{ source('adventure_works', 'person_address') }}
    ),

    renamed as (
        select
            addressid as id_endereco,
            stateprovinceid as id_estado,
            city as cidade
        from source
    )

select *
from renamed