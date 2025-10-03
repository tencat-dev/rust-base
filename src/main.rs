#[tokio::main]
async fn main() {
    dotenvy::dotenv().ok();

    println!("HOST={}", std::env::var("HOST").unwrap());
}
