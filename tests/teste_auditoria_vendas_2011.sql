-- Teste para validar se o valor bruto de 2011 bate com a auditoria contábil ($12.646.112,16)
with 
    vendas_2011 as (
        select 
            sum(f.valor_bruto) as valor_total_2011
        from {{ ref('fato_vendas') }} f
        left join {{ ref('dim_datas') }} d on f.fk_data = d.sk_data
        where d.ano = 2011
    )

select *
from vendas_2011
where cast(round(valor_total_2011, 2) as decimal(15,2)) != cast(12646112.16 as decimal(15,2))