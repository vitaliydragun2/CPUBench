struct AppData
{
	static let threadOptions = [1, 2, 4, 8, 16, 32, 64, 128]
	static let cycleOptions = [1_000_000_000,
							   2_000_000_000,
							   4_000_000_000,
							   8_000_000_000,
							   16_000_000_000,
							   32_000_000_000,
							   64_000_000_000,
							   128_000_000_000]
}