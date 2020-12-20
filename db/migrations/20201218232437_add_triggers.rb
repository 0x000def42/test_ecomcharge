Hanami::Model.migration do
  change do
    <<-SQL
      CREATE OR REPLACE FUNCTION update_avg_rate() RETURNS TRIGGER AS $$
      DECLARE
        new_rate_avg float;
        new_rate_count integer; 
        new_rate_sum integer;
      BEGIN

        SELECT rate_sum, rate_count INTO prev_rates FROM posts WHERE id = NEW.post_id;

        IF TG_OP = 'INSERT' THEN
          new_rate_count := prev_rates.rate_count + 1;
          new_rate_sum := prev_rates.rate_sum + NEW.value;
        ELSIF TG_OP = 'UPDATE' THEN
          new_rate_count := prev_rates.rate_count;
          new_rate_sum := prev_rates.rate_sum - OLD.value + NEW.value;
        ELSIF TG_OP = 'DELETE' THEN
          new_rate_count := prev_rates.rate_count - 1;
          new_rate_sum := prev_rates.rate_sum - OLD.value;
        END IF;

        new_rate_avg := new_rate_sum / new_rate_count;

        UPDATE posts 
          SET rate_count = new_rate_count, 
              rate_avg = new_rate_avg
              rate_sum = new_rate_sum
          WHERE id = NEW.post_id

      END;
      $$ LANGUAGE plpgsql;

    CREATE TRIGGER t_rate
      BEFORE CREATE OR DELETE OR UPDATE ON rates
      FOR EACH ROW
      EXECUTE PROCEDURE update_avg_rate();
    SQL
  end
end
