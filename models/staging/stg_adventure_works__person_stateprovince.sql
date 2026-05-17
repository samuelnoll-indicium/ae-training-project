with 
    source as (
        select * from {{ source('adventure_works', 'person_stateprovince') }}
    ),

    renamed as (
        select
            stateprovinceid as id_estado,
            countryregioncode as codigo_pais,
            name as nome_estado
        from source
    )

select * from renamed