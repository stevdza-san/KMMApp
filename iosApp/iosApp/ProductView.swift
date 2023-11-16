import Foundation
import shared
import SwiftUI

struct ProductView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: product.image)) { imageUrl in
                if let image = imageUrl.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .animation(.default, value: image)
                        .accessibility(hidden: false)
                        .accessibilityLabel(Text("Product Thumbnail"))
                } else if imageUrl.error != nil {
                    VStack {
                        Text("Image not available.")
                            .font(.title3)
                    }
                } else {
                    ProgressView().frame(maxWidth: .infinity)
                }
            }
            Text(product.title)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .truncationMode(.tail)
                .font(.title2.bold())
                .padding(.top, 10)
            Text(product.description_)
                .multilineTextAlignment(.leading)
                .lineLimit(6)
                .truncationMode(.tail)
                .font(.body)
                .padding(.top, 5)
                .padding(.bottom, 10)
            HStack {
                Text(product.category)
                    .font(.body.italic())
                Spacer()
                Text("$\(String(format: "%.2f", product.price))")
                    .font(.body.bold())
            }
            .padding(.vertical, 10)
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleProduct = Product(
            id: 1,
            title: "My Title",
            price: 100.0,
            description: "My product description", 
            category: "Man",
            image: ""
        )

        ProductView(product: sampleProduct).padding()
    }
}
