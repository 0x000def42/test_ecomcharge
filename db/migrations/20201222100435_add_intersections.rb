Hanami::Model.migration do
  change do
    create_table :intersections do
      primary_key :id

      foreign_key :user_id, :users, type: Integer, on_delete: :cascade, null: false
      column :ip, String, null: false
      column :counter, Integer, null: false, default: 1

      index [:ip, :user_id], unique: true

    end

    create_function(:post_intersections_calc, <<-SQL, language: :plpgsql, returns: :trigger)
      DECLARE
        old_counter integer;
      BEGIN
        IF (TG_OP = 'INSERT') THEN
          SELECT counter 
          INTO old_counter 
          FROM intersections 
          WHERE user_id = NEW.user_id and ip = NEW.ip;

          IF old_counter IS NOT NULL THEN
            UPDATE intersections 
            SET counter = old_counter + 1
            where user_id = NEW.user_id and ip = NEW.ip;
          ELSE
            INSERT INTO intersections (ip, user_id, counter) VALUES (NEW.ip, NEW.user_id, 1);
          END IF;
          RETURN NEW;
        ELSIF (TG_OP = 'UPDATE') THEN
          IF NEW.user_id != OLD.user_id OR NEW.ip != OLD.ip THEN
            SELECT `counter` into old_counter 
            from intersections 
            where user_id = OLD.user_id and ip = OLD.ip 
            limit 1;

            UPDATE intersections 
            SET counter = old_counter - 1
            where user_id = OLD.user_id and ip = OLD.ip;

            SELECT `counter` into old_counter 
            from intersections 
            where user_id = NEW.user_id and ip = NEW.ip 
            limit 1;

            IF old_counter IS NOT NULL THEN
              UPDATE intersections 
              SET counter = old_counter + 1
              where user_id = NEW.user_id and ip = NEW.ip;
            ELSE
              INSERT INTO intersections
              (ip, user_id, counter)
              VALUES
              (NEW.ip, NEW.user_id, 1);
            END IF;

          END IF;
          RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
          SELECT `counter` into old_counter 
          from intersections 
          where user_id = OLD.user_id and ip = OLD.ip 
          limit 1;

          UPDATE intersections 
          SET counter = old_counter - 1
          where user_id = NEW.user_id and ip = NEW.ip;

        END IF;

        RETURN OLD;
      END
    SQL

    create_trigger(
      :posts,
      :post_intersections_trigger, 
      :post_intersections_calc, 
      events: [:insert, :update, :delete],
      each_row: true
    )

  end
end
