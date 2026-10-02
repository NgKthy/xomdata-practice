-- Xom Data · Delivery performance by size class
-- Problem: https://xomdata.com/practice/medium-case-160
-- Solved: 2026-10-02

with truck_stats as (
    select t.id, t.vehicle_type, t.capacity_tons,
        case
            when t.capacity_tons >= 10 then 'Large Truck'
            when t.capacity_tons >= 5 then 'Medium Truck'
            else 'Small Truck'
        end as size_class,
        count(distinct s.id) as shipment_count,
        count(distinct case when d.results = 'success' then s.id end) as delivered
    from trucks t
    left join shipments s on s.truck_id = t.id
    left join deliveries d on d.shipment_id = s.id
    group by t.id, t.vehicle_type, t.capacity_tons
)
select vehicle_type, capacity_tons, shipment_count,
    size_class, delivered,
    round(
        case
            when shipment_count = 0 then 0
            else 100.0 * delivered / shipment_count
        end,
        2
    ) as delivery_rate,
    rank() over (
        partition by size_class
        order by
            case
                when shipment_count = 0 then 0
                else 100.0 * delivered / shipment_count
            end desc
    ) as rank_in_size
from truck_stats
order by size_class, rank_in_size, vehicle_type;
