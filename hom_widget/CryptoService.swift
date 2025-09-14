import Foundation

struct CryptoPrice: Decodable {
    let instId: String
    let last: String
}


struct OKXResponse: Decodable {
    let code: String
    let msg: String
    let data: [Ticker]
}

struct Ticker: Decodable {
    let instId: String
    let last: String
}

class CryptoService {
    func fetchCryptoPrices(completion: @escaping ([Ticker]?) -> Void) {
           let urlString = "https://www.okx.com/api/v5/market/tickers?instType=SPOT"
           guard let url = URL(string: urlString) else {
               completion(nil)
               return
           }

           URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data, error == nil else {
                   print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                   completion(nil)
                   return
               }

               do {
                   // Decode the full OKXResponse object
                   let decodedResponse = try JSONDecoder().decode(OKXResponse.self, from: data)
                   
                   // Pass the 'data' array to the completion handler
                   completion(decodedResponse.data)
               } catch {
                   print("Decoding error: \(error)")
                   completion(nil)
               }
           }.resume()
       }
}
