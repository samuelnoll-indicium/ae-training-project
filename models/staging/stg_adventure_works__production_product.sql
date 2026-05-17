with 
    source as (
        select * from {{ source('adventure_works', 'production_product') }}
    ),

    renamed as (
        select
            productid as id_produto,
            name as nome_produto,
            productnumber as codigo_produto
        from source
    )

select * from renamed