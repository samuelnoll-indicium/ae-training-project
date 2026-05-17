with 
    source as (
        select * from {{ source('adventure_works', 'sales_salesorderheader') }}
    ),

    renamed as (
        select
            salesorderid as id_pedido,
            customerid as id_cliente,
            territoryid as id_territorio,
            billtoaddressid as id_endereco_faturamento,
            shiptoaddressid as id_endereco_entrega,
            cast(creditcardid as int) as id_cartao,
            cast(orderdate as timestamp) as data_pedido,
            cast(duedate as timestamp) as data_vencimento,
            cast(shipdate as timestamp) as data_envio,
            status as status_pedido,
            subtotal as valor_subtotal,
            taxamt as valor_imposto,
            freight as valor_frete,
            totaldue as valor_total
        from source
    )

select * 
from renamed