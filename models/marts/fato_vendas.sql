with 
    stg_header as (
        select * from {{ ref('stg_adventure_works__sales_salesorderheader') }}
    ),

    stg_detail as (
        select * from {{ ref('stg_adventure_works__sales_salesorderdetail') }}
    ),

    -- Desduplicando os motivos: pegamos apenas o 1º motivo associado a cada pedido
    stg_ponte_motivo as (
        select 
            id_pedido, 
            id_motivo_venda
        from (
            select 
                id_pedido, 
                id_motivo_venda,
                row_number() over(partition by id_pedido order by id_motivo_venda) as rn
            from {{ ref('stg_adventure_works__sales_salesorderheadersalesreason') }}
        ) sub
        where rn = 1
    ),

    joined as (
        select
            d.id_detalhe_pedido,
            d.id_pedido,
            d.id_produto,
            h.id_cliente,
            h.id_endereco_entrega as id_localidade,
            h.id_cartao,
            m.id_motivo_venda,
            cast(to_date(h.data_pedido) as string) as id_data,
            h.status_pedido,
            d.quantidade_comprada,
            d.preco_unitario,
            d.desconto_preco_unitario,
            (d.preco_unitario * d.quantidade_comprada) as valor_bruto,
            ((d.preco_unitario * d.quantidade_comprada) * (1 - d.desconto_preco_unitario)) as valor_liquido,
            ((d.preco_unitario * d.quantidade_comprada) * d.desconto_preco_unitario) as desconto

        from stg_detail d
        left join stg_header h on d.id_pedido = h.id_pedido
        left join stg_ponte_motivo m on d.id_pedido = m.id_pedido
    ),

    transformed as (
        select
            md5(cast(id_detalhe_pedido as string) || '-' || coalesce(cast(id_motivo_venda as string), 'sem_motivo')) as sk_venda,
            md5(cast(id_produto as string)) as fk_produto,
            md5(cast(id_cliente as string)) as fk_cliente,
            md5(cast(id_localidade as string)) as fk_localidade,
            coalesce(md5(cast(id_cartao as string)), md5('sem_cartao')) as fk_cartao,
            coalesce(md5(cast(id_motivo_venda as string)), md5('sem_motivo')) as fk_motivo_venda,
            id_data as fk_data,
            id_pedido,
            status_pedido,
            quantidade_comprada,
            valor_bruto,
            valor_liquido,
            desconto
        from joined
    )

select *
from transformed