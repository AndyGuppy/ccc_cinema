require('pg')

class SqlRunner

  def self.run( sql )
    begin
      db = PG.connect({ dbname: 'ccc_cinema', host: 'localhost' })
      result = db.exec( sql )
    ensure
      db.close
    end
    return result
  end

  def self.with_db
    db = PG.connect({ dbname: 'ccc_cinema', host: 'localhost' })
    begin
     yield db
   ensure
     db.close
   end
 end

 def self.reset(fname)
  sql = File.open(fname, 'rb') { |file| file.read }
  SqlRunner.with_db do |db|
    begin
      db.exec(sql)
    rescue PG::Error
       #####
     end
   end
 end
end
