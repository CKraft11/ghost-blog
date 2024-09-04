import assetNegotiationPlugin from "../../..";

export const onRequest: PagesFunction = assetNegotiationPlugin({
	formats: ['webp'],
});