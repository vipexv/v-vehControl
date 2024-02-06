import {
  AlertTriangle,
  ArrowLeft,
  ArrowRight,
  Lightbulb,
  Power,
} from "lucide-react";
import React, { useState } from "react";
import { VehicleData } from "../../types/VehicleData";
import { fetchNui } from "../../utils/fetchNui";
import IconButton from "./IconButton";
import { ResourceConfig } from "../../types/ResourceConfig";

interface Props {
  vehicleData: VehicleData | undefined;
  resourceConfig: ResourceConfig | undefined;
}

const MiscellaneousActions: React.FC<Props> = React.memo(
  ({ vehicleData, resourceConfig }) => {
    const [disabledButton, setDisabledButton] = useState<string | undefined>(
      undefined
    );

    const handleButtonClick = (data: { option: string }) => {
      if (!disabledButton) {
        setDisabledButton(data.option);
        fetchNui("vehmenu:toggleoption", data);
        setTimeout(() => {
          setDisabledButton(undefined);
        }, 500);
      }
    };

    return (
      <>
        <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] w-full h-[10dvh] rounded-[2px]">
          <div className="flex flex-col gap-2 justify-center items-center font-main">
            <p className="bg-gradient-to-r px-10 py-1 mt-2 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold">
              {resourceConfig?.Translation?.tab_miscellaneous}
            </p>
            <div className="flex w-full justify-center items-center gap-2 text-white">
              <IconButton
                onClick={() => {
                  handleButtonClick({
                    option: "engine",
                  });
                }}
                loading={disabledButton === "engine"}
                Icon={Power}
                disabled={
                  vehicleData?.currSeat !== -1 || disabledButton === "engine"
                }
                isActive={!!vehicleData?.engineOn}
              />
              <IconButton
                onClick={() => {
                  handleButtonClick({
                    option: "left_blinker",
                  });
                }}
                loading={disabledButton === "left_blinker"}
                Icon={ArrowLeft}
                disabled={
                  vehicleData?.currSeat !== -1 ||
                  disabledButton === "left_blinker"
                }
                isActive={[1, 3].includes(
                  vehicleData?.indicatorLights
                    ? vehicleData?.indicatorLights
                    : 0
                )}
              />
              <IconButton
                onClick={() => {
                  handleButtonClick({
                    option: "alert",
                  });
                }}
                loading={disabledButton === "alert"}
                Icon={AlertTriangle}
                disabled={
                  vehicleData?.currSeat !== -1 || disabledButton === "alert"
                }
                isActive={vehicleData?.indicatorLights === 3}
              />
              <IconButton
                onClick={() => {
                  handleButtonClick({
                    option: "right_blinker",
                  });
                }}
                loading={disabledButton === "right_blinker"}
                Icon={ArrowRight}
                disabled={
                  vehicleData?.currSeat !== -1 ||
                  disabledButton === "right_blinker"
                }
                isActive={[2, 3].includes(
                  vehicleData?.indicatorLights
                    ? vehicleData?.indicatorLights
                    : 0
                )}
              />
              <IconButton
                onClick={() => {
                  handleButtonClick({
                    option: "interior_light",
                  });
                }}
                loading={disabledButton === "interior_light"}
                Icon={Lightbulb}
                disabled={
                  vehicleData?.currSeat !== -1 ||
                  disabledButton === "interior_light"
                }
                isActive={
                  vehicleData?.interiorLight ? vehicleData.interiorLight : false
                }
              />
            </div>
          </div>
        </div>
      </>
    );
  }
);

export default MiscellaneousActions;
