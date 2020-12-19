Hanami::Model.migration do
  change do
    <<-SQL
      CREATE OR REPLACE FUNCTION update_avg_rate() RETURNS TRIGGER AS $$
      DECLARE
        new_rate_avg float;
        new_rate_count integer; 
      BEGIN

        SELECT rate_avg, rate_count INTO prev_rates FROM posts WHERE id = NEW.post_id;

        IF TG_OP = 'INSERT' THEN
          new_rate_count := prev_rates.rate_count + 1;
          new_rate_avg := (prev_rates.rate_avg * prev_rates.rate_count + NEW.value) / new_rate_count;
        ELSIF TG_OP = 'UPDATE' THEN
          new_rate_count := prev_rates.rate_count;
          new_rate_avg := (prev_rates.rate_avg * prev_rates.rate_count - OLD.value + NEW.value) / new_rate_count;
        ELSIF TG_OP = 'DELETE' THEN
          new_rate_count := prev_rates.rate_count - 1;
          new_rate_avg := (prev_rates.rate_avg * prev_rates.rate_count - OLD.value) / new_rate_count;
        END IF;

        UPDATE posts 
          SET rate_count = new_rate_count, 
              rate_avg = new_rate_avg
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
