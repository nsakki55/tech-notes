SELECT purchase_id,
       amount,
       coupon,
       amount - coupon as discount_amount1,
       amount - COALESCE(coupon, 0) AS discount_amount2
FROM purchase_log_with_coupon