with 
    limites_vendas as (
        select
            date_trunc('year', min(data_pedido)) as data_inicio,
            date_trunc('year', max(data_pedido)) + interval 1 year - interval 1 day as data_fim
        from {{ ref('stg_adventure_works__sales_salesorderheader') }}
    ),

    date_series as (
        select explode(sequence(
            (select data_inicio from limites_vendas), 
            (select data_fim from limites_vendas), 
            interval 1 day
        )) as data_dia
    ),

    transformed as (
        select
            cast(to_date(data_dia) as string) as sk_data,
            cast(data_dia as date) as data,
            year(data_dia) as ano,
            month(data_dia) as mes,
            date_format(data_dia, 'MMMM') as nome_mes,
            date_format(data_dia, 'yyyy-MM') as mes_ano
        from date_series
    )

select *
from transformed