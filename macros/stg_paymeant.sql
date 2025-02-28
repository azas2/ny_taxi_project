{% macro get_payment_discription(payment_type)%}
case cast ({{payment_type}} as integer) 
when 1 then 'visa'
when 2 then 'cread card'
when 3 then 'no charge'
when 4 then 'dispute'
when 5 then 'unkown'
else 'empty'
end 
{%endmacro%}

                                                                    