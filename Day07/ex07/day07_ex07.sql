select
    trim_scale(round(avg(rating), 4)) as global_rating
from pizzeria;
