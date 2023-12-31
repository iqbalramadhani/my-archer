import * as React from "react";
import { fetchingReducer } from "utils/hooks/fetcher";

import { errorsUtil } from "utils";

function useFetcher() {
  const [state, dispatch] = React.useReducer(fetchingReducer, {
    status: "idle",
    data: null,
    errors: null,
  });

  const { status } = state;

  const runAsync = async (serviceFetcher, { onSuccess, onError, transform } = {}) => {
    if (!serviceFetcher) {
      return;
    }

    dispatch({ status: "loading", errors: null });

    const result = await serviceFetcher();
    if (result.success) {
      dispatch({
        status: "success",
        data: typeof transform === "function" ? transform(result.data) : result.data,
      });
      onSuccess?.();
    } else {
      const fetchingErrors = errorsUtil.interpretServerErrors(result);
      dispatch({ status: "error", errors: fetchingErrors });
      onError?.();
    }
  };

  const isLoading = status === "loading";
  const isSuccess = status === "success";
  const isError = status === "errors";

  return { ...state, state, runAsync, isLoading, isSuccess, isError };
}

export { useFetcher };
