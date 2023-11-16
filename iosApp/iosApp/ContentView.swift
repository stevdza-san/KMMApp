import SwiftUI
import shared

struct ContentView: View {
    @StateObject
    var viewModel = HomeViewModel()

	var body: some View {
        VStack {
            if viewModel.response?.isSuccess() == true {
                List(viewModel.response?.getProducts().items ?? [], id: \.id) { element in
                    ProductView(product: element)
                }
            } else if viewModel.response?.isError() == true {
                VStack {
                    Spacer()
                    Text("\(viewModel.response?.getErrorMessage() ?? "Unknown Error")")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.response?.isLoading() == true {
                VStack {
                    Spacer()
                    ProgressView("Loading")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }.task {
            await viewModel.fetchData()
        }
	}
}

class HomeViewModel: ObservableObject {
    @Published
    private(set) var response: RequestState? = nil
    
    @MainActor
    func fetchData() async {
        for await requestState in ProductsApi().fetchProducts(limit: 10) {
            response = requestState
        }
    }
}
