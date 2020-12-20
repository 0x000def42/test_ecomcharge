Hanami::Model.migration do

  # down do
  #   DB.drop_trigger(:rates, :rate_avg_trigger)
  # end

  up do

    create_function(:rate_update_post_avg, <<-SQL, language: :plpgsql, returns: :trigger)
      DECLARE
        new_rate_avg float;
        new_rate_count integer; 
        new_rate_sum integer;

        prev_rate_sum integer;
        prev_rate_count integer;
      BEGIN

        SELECT rate_sum, rate_count 
        INTO prev_rate_sum, prev_rate_count 
        FROM posts 
        WHERE id = NEW.post_id;
        IF (TG_OP = 'INSERT') THEN
          new_rate_count := prev_rate_count + 1;
          new_rate_sum := prev_rate_sum + NEW.value;
        ELSIF (TG_OP = 'UPDATE') THEN
          new_rate_count :=prev_rate_count;
          new_rate_sum := prev_rate_sum - OLD.value + NEW.value;
        ELSIF (TG_OP = 'DELETE') THEN
          new_rate_count := prev_rate_count - 1;
          new_rate_sum := prev_rate_sum - OLD.value;
        ELSE
          RETURN NULL;
        END IF;

        new_rate_avg := new_rate_sum / new_rate_count::real;
        UPDATE posts 
          SET rate_count = new_rate_count, 
              rate_avg = new_rate_avg,
              rate_sum = new_rate_sum
          WHERE id = NEW.post_id;
        RETURN NULL;
      END;
    SQL

    create_trigger(
      :rates,
      :rate_avg_trigger, 
      :rate_update_post_avg, 
      events: [:insert, :update, :delete],
      after: true,
      each_row: true
    )
  end
end
