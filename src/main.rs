use futures::Future;
use futures_state_stream::StateStream;
use tiberius::SqlConnection;
use tokio::executor::current_thread;

fn main() {
    // 1: for windows we demonstrate the hardcoded variant
    // which is equivalent to:
    //     let conn_str = "server=tcp:localhost,1433;integratedSecurity=true;";
    //     let future = SqlConnection::connect(conn_str).and_then(|conn| {
    // and for linux we use the connection string from an environment variable
    let conn_str =
        "server=tcp:mssql,1433;database=SprocTest;user=sa;password=Str0ngPassW0rd!;encrypt=false"
            .to_owned();

    let future = SqlConnection::connect(conn_str.as_str())
        .and_then(|conn| {
            conn.simple_query("SELECT 1+2").for_each(|row| {
                let val: i32 = row.get(0);
                assert_eq!(val, 3i32);
                Ok(())
            })
        })
        .and_then(|conn| conn.simple_exec("create table #Temp(gg int);"))
        .and_then(|(_, conn)| conn.simple_exec("UPDATE #Temp SET gg=1 WHERE gg=1"));

    current_thread::block_on_all(future).unwrap();
}
