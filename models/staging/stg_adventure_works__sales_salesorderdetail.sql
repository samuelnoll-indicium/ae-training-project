with 
    source as (
        select * from {{ source('adventure_works', 'sales_salesorderdetail') }}
    ),

    renamed as (
        select
            salesorderdetailid as id_detalhe_pedido,
            salesorderid as id_pedido,
            productid as id_produto,
            orderqty as quantidade_comprada,
            unitprice as preco_unitario,
            unitpricediscount as desconto_preco_unitario
        from source
    )

select * 
from renamed